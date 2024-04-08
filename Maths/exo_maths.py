import math

def degrees_to_radians(degrees):
    radians = degrees * (math.pi / 180)
    return radians

def radians_to_degrees(radians):
    degrees = radians * (180 / math.pi)
    return degrees

def area_trapezoid(height, first_base, second_base):
    trapezoid = ((first_base + second_base) * height) / 2
    return trapezoid

def area_parallelogram(length_base, height_parallelogram):
    area = length_base * height_parallelogram
    return area

def surface_volume_area_cylinder(height, radius):
    volume = math.pi * radius ** 2 * height
    surface_area = 2 * math.pi * radius * (radius + height)
    return volume, surface_area

degrees = 15
radians = degrees_to_radians(degrees)
print(f"{degrees} degrees is {radians} radians.")

radians = 52
degrees = radians_to_degrees(radians)
print(f"{radians} radians is {degrees} degrees.")

height = 5
first_base = 5
second_base = 6
trapezoid = area_trapezoid(height, first_base, second_base)
print(f"Area is {trapezoid}")
print(f"Area is {area_trapezoid(5, 5, 6)}") #Autre façon d'afficher le résultat

print(f"Area is {area_parallelogram(5, 6)}")

print(f"Area is {surface_volume_area_cylinder(4, 6)}")
