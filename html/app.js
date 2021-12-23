$(function() {

    var zoneContainer = $('.zoneOwner');
    var zoneOwner = $('.zoneTeamText');

    window.addEventListener('message', function(event) {

        var item = event.data;

        if(item.type == "newKill") {
            addKill(item.killer, item.killed, item.weapon, item.distance);   
        } else if(item.type == "newDeath"){
            newDeath(item.killed);
        }
    })
})

function addKill(killer, killed, weapon, distance) {
    $('<div class="killContainer"><span class="killer">' + killer + '</span><img src="img/' + weapon + '.webp" class="weapon"><span class="killed">' + killed + '</span>  [' + distance + ']  </div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'2px'}, 'slow')
    .delay(3000)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
}
