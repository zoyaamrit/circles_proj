class Interaction {
  void checkInteraction(Circle c1, Circle c2) {
    float d = PVector.dist(c1.position, c2.position);
    float maxRadius = max(c1.radius, c2.radius);

    if (d < maxRadius) {
      // Draw a line between the circles
      color lineColor = lerpColor(c1.c, c2.c, 0.5);
      stroke(lineColor);
      strokeWeight(2);
      line(c1.position.x, c1.position.y, c2.position.x, c2.position.y);

      //if (abs(c1.radius - c2.radius) <= 5) {
        // Add a child circle after a certain time
      }
    }
  }
}
