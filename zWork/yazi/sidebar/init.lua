function Status:render(area)
  self.area = area

  local line = ui.line { self:percentage(), self:position() }
  return {
    ui.Paragraph(area, { line }):align(ui.Paragraph.CENTER)
  }

end
