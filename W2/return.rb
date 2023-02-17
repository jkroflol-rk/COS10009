def sphere_area(radii)
    pi = 3.14159
    area = pi * 4 * radii * radii
   
end


puts ("the sphere has a surface area of ") + sphere_area(10).round(3).to_s
puts ("the sphere has a surface area of ") + sphere_area(5).round(3).to_s