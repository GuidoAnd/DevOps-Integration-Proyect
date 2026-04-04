from flask import Flask, render_template, url_for, request, redirect
import requests

def create_app():
    app = Flask(__name__)

    @app.route('/')
    def index():    
        try:
            response = requests.get('https://pokeapi.co/api/v2/pokemon/?limit=-1')
            data = response.json()
            pokemon = [" ".join(i["name"].split("-")).title() for i in data["results"]]
        except Exception as e:
            print(f"Error en API: {e}")
            pokemon = []
    
        return render_template('index.html', pokemon=pokemon)


    @app.route('/health')
    def health():
        return {"status": "ok"}, 200

    @app.route('/<pokemon>')
    def pokemon(pokemon):
        try:
            res = requests.get(f'https://pokeapi.co/api/v2/pokemon/{pokemon}')
            if res.status_code != 200:
                return redirect(url_for('index'))
            
            req = res.json()
            
            stats = req['stats']
            types = req['types']
            name = " ".join(req['name'].split("-")).title()
            weight = req['weight']
                    
            s = req['sprites']
            raw_sprites = [
                s.get('front_default'), s.get('back_default'),
                s.get('front_female'),  s.get('back_female'),
                s.get('front_shiny'),    s.get('back_shiny'),
                s.get('front_shiny_female'), s.get('back_shiny_female')
            ]
                
            sprites = [i if i is not None else "" for i in raw_sprites]
            
            return render_template('pokemon.html', stats=stats, types=types, sprites=sprites, name=name, weight=weight)
        except Exception as e:
            print(f"Error: {e}")
            return redirect(url_for('index'))

    @app.route('/get_pokemon', methods=['POST'])
    def get_pokemon():
        pokemon = request.form.get('pokemon', '').strip()
        if not pokemon:
            return redirect(url_for('index'))
        
        pk = "-".join(pokemon.lower().split(" "))
        return redirect(url_for('pokemon', pokemon=pk))    

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(host="0.0.0.0", port=8000, debug=True)