const PptxGenJS = require("pptxgenjs");
const { readFileSync } = require("fs");

const [planPath, outputPath] = process.argv.slice(2);
if (!planPath || !outputPath) {
  console.error("Usage: node generate.js <plan.json> <output.pptx>");
  process.exit(1);
}

const plan = JSON.parse(readFileSync(planPath, "utf-8"));
const pptx = new PptxGenJS();

pptx.defineLayout({ name: "WIDE", width: 13.33, height: 7.5 });
pptx.layout = "WIDE";

const COLORS = {
  primary: "1E3A5F",
  secondary: "4A90D9",
  accent: "E67E22",
  danger: "E74C3C",
  text: "1F2937",
  textLight: "6B7280",
  bg: "FFFFFF",
  codeBg: "F3F4F6",
  tableHeader: "1E3A5F",
  tableHeaderText: "FFFFFF",
  tableAlt: "F9FAFB",
};

for (const slide of plan.slides) {
  const slideObj = pptx.addSlide();
  slideObj.background = { fill: COLORS.bg };

  slideObj.addText(slide.title, {
    x: 0.5,
    y: 0.3,
    w: 12.33,
    h: 0.7,
    fontSize: 28,
    fontFace: "Microsoft JhengHei",
    bold: true,
    color: COLORS.primary,
  });

  slideObj.addShape(pptx.ShapeType.rect, {
    x: 0.5,
    y: 1.05,
    w: 1.5,
    h: 0.04,
    fill: { color: COLORS.accent },
  });

  if (slide.main_point) {
    slideObj.addText(slide.main_point, {
      x: 0.5,
      y: 1.4,
      w: 12.33,
      h: 5.5,
      fontSize: 18,
      fontFace: "Microsoft JhengHei",
      color: COLORS.text,
      valign: "top",
    });
  }

  slideObj.addText(`${slide.page}`, {
    x: 12.5,
    y: 7.0,
    w: 0.5,
    h: 0.3,
    fontSize: 10,
    fontFace: "Consolas",
    color: COLORS.textLight,
    align: "right",
  });
}

pptx.writeFile({ fileName: outputPath }).then(() => {
  console.log(`PPTX saved: ${outputPath}`);
});
