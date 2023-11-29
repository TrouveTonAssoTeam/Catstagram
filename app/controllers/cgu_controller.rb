class CguController < ApplicationController
    def show
        @cgu_text = { title: "Conditions Générales d'Utilisation", last_updated: "Dernière mise à jour", welcome: "Bienvenue", acceptance: "Acceptance" }
    end
  
    def accept
      # Gérer l'acceptation ici, par exemple, sauvegarder dans la base de données
      redirect_to root_path, notice: "Merci d'avoir accepté les CGU."
    end
  end
  