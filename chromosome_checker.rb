class ChromosomeChecker

    GLOBE_PATTERN = /(A+(TAC|CAT)A)/    
    EYES_PATTERN  = /T(CG*T)*AG/
    LEGS_PATTERN  = /CG*T/
  
  private
  
    def find_end_eyes(sub_chromosome, eyes_start)
      if sub_chromosome.index(EYES_PATTERN, eyes_start) == eyes_start
        eyes_end_before = eyes_start + sub_chromosome.match(EYES_PATTERN, eyes_start)[0].length
        eyes_end_after = find_end_eyes(sub_chromosome, eyes_end_before)
        if eyes_end_after == -1
          return eyes_end_before
        end
        return eyes_end_after
      else
        return -1
      end
    end
  
    def find_end_legs(sub_chromosome, legs_start)
      if sub_chromosome.index(LEGS_PATTERN, legs_start) == legs_start
        legs_end_before = legs_start + sub_chromosome.match(LEGS_PATTERN, legs_start)[0].length
        legs_end_after = find_end_legs(sub_chromosome, legs_end_before)
        if legs_end_after == -1
          return legs_end_before
        end
        return legs_end_after
      else
        return -1
      end
    end
  
    def validate_head(chromosome)
  
      globe_start = chromosome.index(GLOBE_PATTERN)
      globe_end = globe_start + chromosome.match(GLOBE_PATTERN)[0].length
    
      eyes_end = find_end_eyes(chromosome, globe_end)
    
      if eyes_end == -1
        return false, -1
      end
        return true, eyes_end
    end
  
    def validate_body(chromosome, position)
  
      eyes_end = position
      globe_start = chromosome.index(GLOBE_PATTERN, eyes_end)
  
      if globe_start != eyes_end
        return false, -1
      end
  
      globe_end = globe_start + chromosome.match(GLOBE_PATTERN, globe_start)[0].length
  
      legs_end = find_end_legs(chromosome, globe_end)
  
      if legs_end == -1
        return false, -1
      end
  
      return true, legs_end
  
    end
  
  public
  
    def validate_chromosome(chromosome)
  
      valid_head, head_end = validate_head(chromosome)
  
      if valid_head
        valid_body, body_end = validate_body(chromosome, head_end)
        if valid_body
          while body_end < chromosome.length
            valid_body, body_end = validate_body(chromosome, body_end)
            #Stop infinity loop in case of body_end = -1
            if valid_body == false
              break
            end
          end
          return true
        else
          return false
        end
    end
  
  end
  
  end
  