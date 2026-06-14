/* =========================================================
   SafeCity — app.js (v2)
   Scroll reveal, smooth interactions, micro-animations
   ========================================================= */

'use strict';

// ── SCROLL REVEAL ──────────────────────────────────────────
function initScrollReveal() {
  const revealEls = document.querySelectorAll('.reveal');

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          // Stagger siblings within the same parent
          const siblings = Array.from(entry.target.parentElement.querySelectorAll('.reveal'));
          const idx = siblings.indexOf(entry.target);
          setTimeout(() => {
            entry.target.classList.add('in-view');
          }, Math.max(0, idx) * 100);
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1, rootMargin: '0px 0px -50px 0px' }
  );

  revealEls.forEach(el => observer.observe(el));
}

// ── NAVBAR SHRINK ON SCROLL ────────────────────────────────
function initNavbar() {
  const nav = document.querySelector('.nav');
  if (!nav) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 60) {
      nav.style.padding = '8px 20px';
      nav.style.boxShadow = '0 10px 30px rgba(0,0,0,0.05)';
    } else {
      nav.style.padding = '10px 20px';
      nav.style.boxShadow = 'var(--sh-card)';
    }
  }, { passive: true });
}

// ── ACTIVE NAV LINK HIGHLIGHT ──────────────────────────────
function initActiveNav() {
  const sections = document.querySelectorAll('section[id]');
  const navLinks = document.querySelectorAll('.nav-link');

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          navLinks.forEach(link => {
            link.style.color = '';
            link.style.background = '';
            if (link.getAttribute('href') === `#${entry.target.id}`) {
              link.style.color = 'var(--accent)';
              link.style.background = 'rgba(124,58,237,0.08)';
            }
          });
        }
      });
    },
    { threshold: 0.4 }
  );

  sections.forEach(s => observer.observe(s));
}

// ── SOS BUTTON CLICK EASTER EGG ────────────────────────────
function initSOSInteraction() {
  const sosMock = document.querySelector('.sos-mock');
  const phoneBtn = document.querySelector('.ps-red');
  const dlpSosBtn = document.querySelector('.dlp-sos-btn');

  function triggerSOSEffect(el) {
    if (!el) return;
    el.style.transform = 'scale(0.88)';
    el.style.transition = 'transform 0.15s ease';
    setTimeout(() => {
      el.style.transform = 'scale(1)';
    }, 150);
  }

  sosMock?.addEventListener('click', () => triggerSOSEffect(sosMock));
  phoneBtn?.addEventListener('click', () => triggerSOSEffect(phoneBtn));
  dlpSosBtn?.addEventListener('click', () => triggerSOSEffect(dlpSosBtn));
}

// ── SMOOTH DOWNLOAD BUTTON RIPPLE ─────────────────────────
function initRipple() {
  const rippleBtns = document.querySelectorAll('.btn');

  rippleBtns.forEach(btn => {
    btn.addEventListener('click', function (e) {
      const rect = this.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      const ripple = document.createElement('span');
      ripple.style.cssText = `
        position: absolute;
        border-radius: 50%;
        transform: scale(0);
        animation: ripple-expand 0.55s linear;
        background: rgba(255,255,255,0.3);
        pointer-events: none;
        width: 200px; height: 200px;
        left: ${x - 100}px;
        top:  ${y - 100}px;
      `;

      if (window.getComputedStyle(this).position === 'static') {
        this.style.position = 'relative';
      }
      this.style.overflow = 'hidden';

      this.appendChild(ripple);
      setTimeout(() => ripple.remove(), 600);
    });
  });

  if (!document.getElementById('ripple-style')) {
    const style = document.createElement('style');
    style.id = 'ripple-style';
    style.textContent = `
      @keyframes ripple-expand {
        to { transform: scale(4); opacity: 0; }
      }
    `;
    document.head.appendChild(style);
  }
}

// ── HERO PARALLAX (subtle) ─────────────────────────────────
function initParallax() {
  const chips = document.querySelectorAll('.float-chip');
  if (chips.length === 0) return;

  window.addEventListener('mousemove', (e) => {
    const cx = window.innerWidth / 2;
    const cy = window.innerHeight / 2;
    const dx = (e.clientX - cx) / cx;
    const dy = (e.clientY - cy) / cy;

    chips.forEach((chip, i) => {
      const factor = (i % 2 === 0 ? 1 : -1) * (i + 1) * 3;
      chip.style.transform = `translate(${dx * factor}px, ${dy * factor}px)`;
    });
  }, { passive: true });
}

// ── COUNTER ANIMATION ─────────────────────────────────────
function animateCounter(el, target, suffix = '') {
  const isSpecial = isNaN(parseInt(target));
  if (isSpecial) return;

  const num = parseInt(target);
  const dur = 1200;
  const steps = 40;
  const step = dur / steps;
  let current = 0;

  const interval = setInterval(() => {
    current += num / steps;
    if (current >= num) {
      current = num;
      clearInterval(interval);
    }
    el.textContent = Math.floor(current) + (suffix || '');
  }, step);
}

function initCounters() {
  const statNumbers = document.querySelectorAll('.mini-stat strong');
  
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        const el = entry.target;
        const orig = el.textContent;
        const suffix = orig.includes('+') ? '+' : '';
        
        if (!isNaN(parseInt(orig))) {
          el.textContent = '0' + suffix;
          animateCounter(el, orig, suffix);
        }
        observer.unobserve(el);
      }
    });
  }, { threshold: 0.5 });

  statNumbers.forEach(el => observer.observe(el));
}

// ── BOOT ──────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  initScrollReveal();
  initNavbar();
  initActiveNav();
  initSOSInteraction();
  initRipple();
  initCounters();

  if (window.innerWidth > 900) {
    initParallax();
  }
});
