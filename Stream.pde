import java.util.*;
import java.util.stream.*;
import java.util.concurrent.atomic.AtomicLong;

List<Particula> particulas = new ArrayList<>();
int maximoParticulas = 500;

// Gerador de Stream
Stream<Particula> fluxoParticula;
Iterator<Particula> iteradorParticula;

void setup() {
  size(800, 600);
  background(0);
  
  fluxoParticula = Stream.iterate(0, n -> n + 1).map(n -> gerarParticulaAleatoria());
  iteradorParticula = fluxoParticula.iterator();
}

void draw() {
  background(0, 25); // Efeito de trilha

  // Adiciona novas partículas até atingir o máximo
  while (particulas.size() < maximoParticulas && iteradorParticula.hasNext()) {
    Particula novaParticula = iteradorParticula.next();
    particulas.add(novaParticula);
  }

  // Atualiza e exibe todas as partículas usando Streams
  particulas.stream()
            .map(p -> { p.atualizar(); return p; })
            .forEach(Particula::exibir);

  // Remove partículas que têm duracaoVida <= 0 usando streams
  particulas = particulas.stream()
                          .filter(p -> p.duracaoVida > 0)
                          .collect(Collectors.toList());
}

Particula gerarParticulaAleatoria() {
  PVector pos = new PVector(random(width), random(height));
  PVector vel = PVector.random2D().mult(random(1, 3));
  color corAleatoria = color(random(255), random(255), random(255), 200);
  return new Particula(pos, vel, corAleatoria);
}
