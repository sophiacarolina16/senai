const dadosEmergencia = {
    socorros: {
        banner: "Primeiros Socorros - Atendimento Imediato",
        fazer: [
            "Avaliar a segurança do local antes de se aproximar",
            "Chamar o SAMU (192) ou Bombeiros (193)",
            "Verificar a respiração e o pulso da vítima",
            "Manter a vítima calma e aquecida",
            "Aguardar o socorro especializado no local"
        ],
        naoFazer: [
            "NÃO mover a vítima sem necessidade",
            "NÃO oferecer água ou alimentos",
            "NÃO dar medicação por conta própria",
            "NÃO retirar capacete em caso de motociclista",
            "NÃO aplicar produtos caseiros em queimaduras"
        ]
    },
    incendio: {
        banner: "Procedimentos de Emergência para Incêndios e Evacuação",
        fazer: [
            "Acionar o alarme de incêndio imediatamente",
            "Ligar para o Corpo de Bombeiros (193)",
            "Utilizar as saídas de emergência sinalizadas",
            "Caminhar abaixado em caso de fumaça densa",
            "Dirigir-se ao Ponto de Encontro seguro"
        ],
        naoFazer: [
            "NÃO utilizar elevadores durante o incêndio",
            "NÃO retornar para buscar objetos pessoais",
            "NÃO correr ou causar pânico na evacuação",
            "NÃO abrir portas sem verificar se estão quentes",
            "NÃO combater o fogo se não tiver treinamento"
        ]
    },
    quimico: {
        banner: "Procedimentos em Vazamentos e Acidentes Químicos",
        fazer: [
            "Isolar e sinalizar a área contaminada",
            "Consultar a ficha de segurança (FISPQ/FDS) do produto",
            "Ligar para a CETESB e emergência",
            "Usar EPIs adequados para contenção",
            "Lavar áreas atingidas com água corrente em abundância"
        ],
        naoFazer: [
            "NÃO inalar vapores ou gases diretamente",
            "NÃO tocar em substâncias desconhecidas",
            "NÃO jogar água em reagentes incompatíveis",
            "NÃO descartar resíduos na rede pública",
            "NÃO permanecer contra o sentido do vento"
        ]
    },
    queda: {
        banner: "Atendimento a Vítimas de Queda de Altura",
        fazer: [
            "Manter a vítima imóvel no local",
            "Chamar resgate médico (192 ou 193) imediatamente",
            "Controlar sangramentos externos visíveis",
            "Estabilizar a cabeça e o pescoço à distância",
            "Manter a calma e confortar a vítima"
        ],
        naoFazer: [
            "NÃO mover ou virar a pessoa sob hipótese alguma",
            "NÃO flexionar a coluna ou pescoço da vítima",
            "NÃO massagear áreas com suspeita de fratura",
            "NÃO permitir que a pessoa tente se levantar",
            "NÃO puxar ou tracionar membros machucados"
        ]
    }
};

function trocarCategoria(chave) {
    const info = dadosEmergencia[chave];

    document.getElementById('banner-titulo').innerText = info.banner;

    const listaFazer = document.getElementById('lista-fazer');
    listaFazer.innerHTML = info.fazer.map(item => `<li>${item}</li>`).join('');

    const listaNaoFazer = document.getElementById('lista-nao-fazer');
    listaNaoFazer.innerHTML = info.naoFazer.map(item => `<li>${item}</li>`).join('');

    const botoes = document.querySelectorAll('.btn-emergencia');
    botoes.forEach(btn => btn.classList.remove('ativo'));

    const btnAtivo = document.getElementById(`btn-${chave}`);
    if (btnAtivo) {
        btnAtivo.classList.add('ativo');
    }
}

window.onload = function() {
    trocarCategoria('socorros');
};