<%@ Page Title="" Language="C#" MasterPageFile="~/portalMaster.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Mustache.WebUI.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Services Section Start -->
    <section id="services" class="section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title wow fadeIn" data-wow-duration="1000ms" data-wow-delay="0.3s">Nossos <span>Cursos</span></h2>
          <hr class="lines wow zoomIn" data-wow-delay="0.3s">
          <p class="section-subtitle wow fadeIn" data-wow-duration="1000ms" data-wow-delay="0.3s">Cursos de Graduação ofertados pelo Centro Universitário Mustache.</p>
        </div>
        <div class="row">
          <div class="col-md-4 col-sm-6" ng-repeat="curso in cursos">
            <div class="item-boxes fadeInDown" data-wow-delay="{{($index + 1) * 0.2 + 's'}}">
              <div class="icon">
                <i ng-class="curso.icone" ></i>
              </div>
              <h4 ng-bind="curso.nome"></h4>
              <p ng-bind="curso.descricao"></p>
            </div>
          </div>
          <!-- <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="0.2s">
              <div class="icon">
                <i class="fa fa-book"></i>
              </div>
              <h4>Administração</h4>
              <p>O curso desenvolve habilidades para a formação do gestor, com o emprego de novas tecnologias, empreendedorismo, criatividade em técnicas de negociação e, principalmente, o entendimento sobre como articular as pessoas para atingir metas determinadas. O conjunto de disciplinas auxilia na formação de administradores éticos e socialmente responsáveis, prontos para tomar decisões e lidar com as constantes mudanças no cenário nacional e internacional.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="0.4s">
              <div class="icon">
                <i class="fa fa-sun-o"></i>
              </div>
              <h4>Agronomia</h4>
              <p>É um campo multidisciplinar que inclui subáreas aplicadas das ciências naturais, exatas, sociais e econômicas que trabalham em conjunto visando a aumentar compreensão da agropecuária e melhorar as práticas agrícolas e zootécnicas, por meio de técnicas e tecnologias em favor de uma otimização da produção dos pontos de vista econômico, técnico, social e ambiental.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="0.6s">
              <div class="icon">
                <i class="fa fa-legal"></i>
              </div>
              <h4>Direito</h4>
              <p>É o ramo das ciências sociais que estuda o sistema de normas que regulam as relações sociais. A formação humanística do curso prepara o estudante para ingressar em um mercado de trabalho dinâmico e competitivo, que exige não apenas habilidades técnicas, mas também uma visão criativa do direito, preparando o aluno ao Exame da Ordem dos Advogados do Brasil.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="0.8s">
              <div class="icon">
                <i class="fa fa-male"></i>
              </div>
              <h4>Educação Física</h4>
              <p>É uma área do conhecimento humano ligada às práticas corporais historicamente produzidas pela humanidade. A educação física é o processo pedagógico que visa à formação do homem capaz de se conduzir plenamente em suas atividades.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="1s">
              <div class="icon">
                <i class="fa fa-medkit"></i>
              </div>
              <h4>Farmácia</h4>
              <p>O curso forma um profissional capaz de atuar nas três grandes áreas da profissão: fármacos e medicamentos; análises clínicas e toxicológicas; produção, controle e análise de alimentos. Será capacitado, ainda, a desenvolver pesquisas e preparo de medicamentos, cosméticos e produtos de higiene pessoal.</p>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="item-boxes wow fadeInDown" data-wow-delay="1.2s">
              <div class="icon">
                <i class="fa fa-desktop"></i>
              </div>
              <h4>Sistemas de Informação</h4>
              <p>Uma das principais áreas em que este profissional atua é no desenvolvimento de software. Ele projeta e desenvolve sistemas a partir das necessidades dos usuários. Também cuida da funcionalidade de sites, garantindo que as informações possam ser acessadas de forma correta e organizada.</p>
            </div>
          </div> -->
        </div>
      </div>
    </section>

    <!-- Start Video promo Section -->
    <section class="video-promo section" data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-md-12 col-sm-12">
              <div class="video-promo-content text-center">
                <h2 class="wow zoomIn" data-wow-duration="1000ms" data-wow-delay="100ms">Siga-nos em nossas redes sociais</h2>
                <p class="wow zoomIn" data-wow-duration="1000ms" data-wow-delay="100ms">Isso não levará nem 10 minutos</p>
                <a href="#" class="video-popup wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="0.3s"><i class="fa fa-twitter"></i></a>
				<a href="#" class="video-popup wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="0.3s"><i class="fa fa-facebook"></i></a>
				<a href="#" class="video-popup wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="0.3s"><i class="fa fa-youtube"></i></a>
				<a href="#" class="video-popup wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="0.3s"><i class="fa fa-linkedin"></i></a>
              </div>
          </div>
        </div>
      </div>
    </section>
    <!-- End Video Promo Section -->

    <!-- Portfolio Section -->
    <section id="portfolios" class="section">
      <!-- Container Starts -->
      <div class="container">
        <div class="section-header">
          <h2 class="section-title wow fadeIn" data-wow-duration="1000ms" data-wow-delay="0.3s">Nosso <span>Trabalho</span></h2>
          <hr class="lines wow zoomIn" data-wow-delay="0.3s">
          <p class="section-subtitle wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="0.3s">Atualmente, o Centro Universitário Mustache está situado na cidade de Uberlândia, Minas Gerais, e abrange {{cursos.length}} cursos no seu portifólio. Abaixo, segue alguns de nossos trabalhos:</p>
        </div>
        <div class="row">
          <div class="col-md-12">
            <!-- Portfolio Controller/Buttons -->
            <div class="controls text-center wow fadeInUp" data-wow-delay=".6s">
              <a class="control mixitup-control-active btn btn-common" data-filter="all">
                All
              </a>
              <a class="control btn btn-common" data-filter=".reuniao">
                Palestras
              </a>
              <a class="control btn btn-common" data-filter=".campus">
                Campus
              </a>
            </div>
            <!-- Portfolio Controller/Buttons Ends-->

            <!-- Portfolio Recent Projects -->
            <div id="portfolio" class="row wow fadeInUp" data-wow-delay="0.8s">
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix reuniao planning">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img1.jpg">
                      <img src="img/portfolio/img1.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix campus">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img2.jpg">
                      <img src="img/portfolio/img2.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix campus">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img3.jpg">
                      <img src="img/portfolio/img3.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix reuniao research">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img4.jpg">
                      <img src="img/portfolio/img4.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix reuniao planning">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img5.jpg">
                      <img src="img/portfolio/img5.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4 col-xl-4 mix planning campus">
                <div class="portfolio-item">
                  <div class="shot-item">
                    <a class="overlay lightbox" href="img/portfolio/img6.jpg">
                      <img src="img/portfolio/img6.jpg" alt="" />
                      <i class="lnr lnr-plus-circle item-icon"></i>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Container Ends -->
    </section>

    <!-- Counter Section Start -->
    <div class="counters section" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-md-3 col-lg-3">
            <div class="wow fadeInUp" data-wow-delay=".2s">
              <div class="facts-item">
                <div class="icon">
                  <i class="lnr lnr-book"></i>
                </div>
                <div class="fact-count">
                  <h3><span class="counter" ng-bind="cursos.length"></span></h3>
                  <h4>Cursos</h4>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3 col-lg-3">
            <div class="wow fadeInUp" data-wow-delay=".4s">
              <div class="facts-item">
                <div class="icon">
                  <i class="lnr lnr-user"></i>
                </div>
                <div class="fact-count">
                  <h3><span class="counter">50</span></h3>
                  <h4>Professores</h4>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3 col-lg-3">
            <div class="wow fadeInUp" data-wow-delay=".6s">
              <div class="facts-item">
                <div class="icon">
                  <i class="lnr lnr-users"></i>
                </div>
                <div class="fact-count">
                  <h3><span class="counter" ng-bind="quantidadeAlunos"></span>+</h3>
                  <h4>Alunos</h4>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-md-3 col-lg-3">
            <div class="wow fadeInUp" data-wow-delay=".8s">
              <div class="facts-item">
                <div class="icon">
                  <i class="lnr lnr-heart"></i>
                </div>
                <div class="fact-count">
                  <h3><span class="counter">16890</span></h3>
                  <h4>Pessoas amaram</h4>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Counter Section End -->

	<!-- Contact Section Start -->
    <section id="contact" class="section">
      <div class="container">
        <div class="row justify-content-md-center">
          <div class="col-md-9 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="0.3s">
            <div class="contact-block">
              <div class="section-header">
                <h2 class="section-title wow fadeIn" data-wow-duration="1000ms" data-wow-delay="0.3s">Contate<span>-nos</span></h2>
                <hr class="lines wow zoomIn" data-wow-delay="0.3s">
              </div>
              <form id="contactForm">
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <input type="text" class="form-control" id="name" name="name" placeholder="Nome" required data-error="Digite seu nome">
                      <div class="help-block with-errors"></div>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <input type="text" placeholder="Email" id="email" class="form-control" name="name" required data-error="Digite seu email">
                      <div class="help-block with-errors"></div>
                    </div>
                  </div>
                   <div class="col-md-12">
                    <div class="form-group">
                      <input type="text" placeholder="Assunto" id="msg_subject" class="form-control" required data-error="Digite o assunto">
                      <div class="help-block with-errors"></div>
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <textarea class="form-control" placeholder="Escreva sua mensagem" rows="11" data-error="Escreva sua mensagem" required></textarea>
                      <div class="help-block with-errors"></div>
                    </div>
                    <div class="submit-button text-center">
                      <button class="btn btn-common" id="submit" type="submit">Enviar Mensagem</button>
                      <div id="msgSubmit" class="h3 text-center hidden"></div>
                      <div class="clearfix"></div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Contact Section End -->

    <!-- Download Section Start -->
    <section id="download" class="section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="0.3s"><span>Baixe</span> Nosso Aplicativo</h2>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="download-area text-center wow fadeInUp" data-wow-delay="0.3s">
                <a href="#" class="btn btn-border"><i class="fa fa-download"></i>Baixar agora</a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Download Section End -->

</asp:Content>
