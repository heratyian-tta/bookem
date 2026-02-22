// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Change to true to allow Turbo
Turbo.session.drive = false

// Allow UJS alongside Turbo
import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;
import Rails from "@rails/ujs"
Rails.start();

const setTheme = (theme) => {
  const root = document.documentElement;
  root.setAttribute("data-theme", theme);
  const toggle = document.querySelector("[data-theme-toggle]");
  if (!toggle) return;
  const isDark = theme === "dark";
  toggle.textContent = isDark ? "Light mode" : "Dark mode";
  toggle.setAttribute("aria-pressed", String(isDark));
};

const initThemeToggle = () => {
  const stored = localStorage.getItem("theme");
  const preferredDark = window.matchMedia?.("(prefers-color-scheme: dark)")?.matches;
  const theme = stored || (preferredDark ? "dark" : "light");
  setTheme(theme);

  const toggle = document.querySelector("[data-theme-toggle]");
  if (!toggle) return;
  toggle.addEventListener("click", () => {
    const current = document.documentElement.getAttribute("data-theme");
    const next = current === "dark" ? "light" : "dark";
    localStorage.setItem("theme", next);
    setTheme(next);
  });
};

document.addEventListener("DOMContentLoaded", initThemeToggle);

const CALENDAR_SLIDE_KEY = "calendarSlideDir";

const applyCalendarSlide = (calendar) => {
  if (!calendar) return;
  const dir = sessionStorage.getItem(CALENDAR_SLIDE_KEY);
  if (dir === "left" || dir === "right") {
    calendar.classList.add(`calendar-slide-${dir}`);
    const onEnd = () => {
      calendar.classList.remove(`calendar-slide-${dir}`);
      calendar.removeEventListener("animationend", onEnd);
    };
    calendar.addEventListener("animationend", onEnd);
    sessionStorage.removeItem(CALENDAR_SLIDE_KEY);
  }
};

const initCalendarSlide = () => {
  const calendar = document.querySelector(".simple-calendar, .calendar, .month-calendar");
  if (!calendar) return;

  const headingLinks = calendar.querySelectorAll(".calendar-heading a");
  if (headingLinks.length > 0) {
    headingLinks[0].dataset.calendarNav = "prev";
    headingLinks[headingLinks.length - 1].dataset.calendarNav = "next";
    headingLinks.forEach((link) => {
      link.dataset.turboFrame = "bookings_calendar";
    });
  }

  applyCalendarSlide(calendar);

  document.addEventListener("click", (event) => {
    const link = event.target.closest("[data-calendar-nav]");
    if (!link) return;

    const dir = link.dataset.calendarNav;
    if (dir !== "prev" && dir !== "next") return;

    sessionStorage.setItem(CALENDAR_SLIDE_KEY, dir === "next" ? "left" : "right");
  });
};

document.addEventListener("DOMContentLoaded", initCalendarSlide);
document.addEventListener("turbo:load", initCalendarSlide);
document.addEventListener("turbo:frame-load", (event) => {
  const frame = event.target;
  if (frame?.id !== "bookings_calendar") return;
  const calendar = frame.querySelector(".simple-calendar, .calendar, .month-calendar");
  applyCalendarSlide(calendar);
  initCalendarSlide();
});
