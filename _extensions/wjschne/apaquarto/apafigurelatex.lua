if FORMAT ~= "latex" then
  return 
end



Div = function(div)
  if div.attributes then
    if div.attributes["apa-note"] then
      div.content = div.content:walk {
        Figure = function(fg)
          if fg.identifier:find("^fig-") then
            fg.content = fg.content:walk {
              Image = function(img)
                img.attributes["apa-note"] = div.attributes["apa-note"]
                return img
              end
            }
            return fg
          end
        end
      }
      return div
    end 
  end
end

