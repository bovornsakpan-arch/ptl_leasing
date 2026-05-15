---
doc_id: "PTL-DT-001"
title: "Design Tokens — PT Leasing"
project: ptl_leasing
type: design
version: "0.1.0"
status: draft
owner: orawan.nus@snocko-tech.com
phase: "02-design"
created_at: "2026-05-15"
updated_at: "2026-05-15"
---

# Design Tokens / Design Tokens

> ค่า design constants ที่ใช้ทั่วทั้งระบบ PT Leasing Backoffice

---

## Colors / สี

### Brand Colors

```css
/* Primary */
--color-primary-50:  #EFF6FF;
--color-primary-100: #DBEAFE;
--color-primary-500: #3B82F6;
--color-primary-600: #2563EB;
--color-primary-700: #1D4ED8;
--color-primary-800: #1E40AF;  /* Main brand */
--color-primary-900: #1E3A8A;

/* Neutral */
--color-neutral-50:  #F9FAFB;  /* Background */
--color-neutral-100: #F3F4F6;
--color-neutral-200: #E5E7EB;
--color-neutral-300: #D1D5DB;
--color-neutral-500: #6B7280;  /* Secondary text */
--color-neutral-700: #374151;  /* Primary text */
--color-neutral-900: #111827;  /* Headings */
```

### Semantic Colors

```css
/* Success */
--color-success-light: #D1FAE5;
--color-success:       #16A34A;
--color-success-dark:  #14532D;

/* Warning */
--color-warning-light: #FEF3C7;
--color-warning:       #D97706;
--color-warning-dark:  #92400E;

/* Danger / Error */
--color-danger-light:  #FEE2E2;
--color-danger:        #DC2626;
--color-danger-dark:   #7F1D1D;

/* Info */
--color-info-light:    #DBEAFE;
--color-info:          #2563EB;
--color-info-dark:     #1E3A8A;
```

### Status Colors (for contract/payment status)

| Status | Background | Text | Border |
|--------|-----------|------|--------|
| Active | #D1FAE5 | #14532D | #16A34A |
| Pending | #FEF3C7 | #92400E | #D97706 |
| Expired | #F3F4F6 | #374151 | #D1D5DB |
| Overdue | #FEE2E2 | #7F1D1D | #DC2626 |
| Terminated | #F3F4F6 | #6B7280 | #D1D5DB |

---

## Typography / ตัวอักษร

```css
/* Font Family */
--font-family-thai: 'Noto Sans Thai', 'Sarabun', sans-serif;
--font-family-en:   'Inter', 'Helvetica Neue', Arial, sans-serif;
--font-family-mono: 'JetBrains Mono', 'Fira Code', monospace;

/* Font Sizes */
--font-size-xs:   12px;
--font-size-sm:   14px;   /* Small text, captions */
--font-size-base: 16px;   /* Body text */
--font-size-lg:   18px;   /* Large text */
--font-size-xl:   20px;   /* Subheadings */
--font-size-2xl:  24px;   /* H3 */
--font-size-3xl:  30px;   /* H2 */
--font-size-4xl:  36px;   /* H1 */

/* Font Weights */
--font-weight-regular: 400;
--font-weight-medium:  500;
--font-weight-semibold: 600;
--font-weight-bold:    700;

/* Line Heights */
--line-height-tight:  1.25;
--line-height-normal: 1.5;
--line-height-relaxed: 1.75;
```

---

## Spacing / ระยะห่าง

```css
/* Base: 4px grid */
--spacing-1:  4px;
--spacing-2:  8px;
--spacing-3:  12px;
--spacing-4:  16px;
--spacing-5:  20px;
--spacing-6:  24px;
--spacing-8:  32px;
--spacing-10: 40px;
--spacing-12: 48px;
--spacing-16: 64px;
--spacing-20: 80px;
```

---

## Border Radius / ความโค้งมน

```css
--radius-sm:   4px;
--radius-md:   8px;   /* Default for cards, inputs */
--radius-lg:   12px;
--radius-xl:   16px;
--radius-full: 9999px;  /* Pills, tags */
```

---

## Shadows / เงา

```css
--shadow-sm:  0 1px 2px rgba(0,0,0,0.05);
--shadow-md:  0 4px 6px rgba(0,0,0,0.07);
--shadow-lg:  0 10px 15px rgba(0,0,0,0.1);
--shadow-xl:  0 20px 25px rgba(0,0,0,0.1);
```

---

## Breakpoints / จุดแบ่ง Responsive

```css
--breakpoint-sm:  640px;   /* Mobile landscape */
--breakpoint-md:  768px;   /* Tablet */
--breakpoint-lg:  1024px;  /* Desktop small */
--breakpoint-xl:  1280px;  /* Desktop */
--breakpoint-2xl: 1536px;  /* Large desktop */
```

---

*อัปเดตล่าสุด: 2026-05-15 | ดูไฟล์ Figma: https://www.figma.com/files/project/587761135*
