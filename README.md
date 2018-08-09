# Objetivo
Este módulo tem por objetivo o reaproveitamento do código e a padronização no provisionamento de instâncias em nossa cloud privada.

## Requisitos
Inicialmente foram considerados os seguintes itens para a construção de instâncias:
1. Instâncias
1.1. Flavor.
1.2. Image.
1.3. Size (volume disco).
1.4. Key pair.
1.5. Network.

2. Security group
2.1. Foram abordadas as regras de ingress para a porta 22 (SSH) e protocolo ICMP.

3. Volume Disco.

4. Template.
4.1. Este requisito aborda a instalação do agente puppet, bem como a configuração inicial do mesmo.