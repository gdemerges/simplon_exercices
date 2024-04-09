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

def surface_volume_area_sphere(radius_sphere):
    surface_volume = (4/3) * math.pi * radius_sphere ** 3
    area_sphere = 4 * math.pi * radius_sphere ** 2
    return surface_volume, area_sphere

def arc_length_angle(diameter_circle, angle_measure):
    arc_lenght = (math.pi * diameter_circle) * (angle_measure / 360)
    return arc_lenght

def area_sector(radius_circle, angle_measure):
    area = (math.pi * radius_circle ** 2) * (angle_measure / 360)
    return area

def discriminant_value(x, y, z):
    discriminant = (y**2) - (4*x*z)
    return discriminant

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

print(f"Area is {surface_volume_area_sphere(0.75)}")

print(f"Area is {arc_length_angle(8, 45)}")

print(f"Area is {area_sector(4, 45)}")

print(f"Area is {discriminant_value(4, 0, -4)}")
