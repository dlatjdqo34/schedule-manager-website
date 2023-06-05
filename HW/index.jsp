<%@ include file="header.jsp" %>
<%@ include file="session_check.jsp" %>

<a href="/logout.jsp"><%=user_id%> Logout</a>

<h1> Schedule </h1>

<label for="search"> Search: </label>
<input type="text" name="search" id="search">
<br><br>

<table id="schetable" border="1" style="text-align:center">
    <thead> 
        <td>Code</td>
        <td>Name</td>
        <td>Start time</td>
        <td>End time</td>
        <td>Day of the Week</td>
    </thead>
    <tbody>
    </tbody>
</table>

<h1> Form </h1>
<label for="name"> Name </label>
<input type="text"  name="name"  id="name"><br>
<label for="start"> Start time </label>
<input type="number" name="start" id="start" min="0" max="23"> <br>
<label for="end"> End time </label>
<input type="number" name="end"  id="end" min="1" max="24"><br>
<label for="dow"> Day of the week </label>
<select name="dow" id="dow">
    <option value="Sun"> Sun </option>
    <option value="Mon"> Mon </option>
    <option value="Tue"> Tue </option>
    <option value="Wed"> Wed </option>
    <option value="Thu"> Thu </option>
    <option value="Fri"> Fri </option>
    <option value="Sat"> Sat </option>
</select> <br>
<button id="submit_btn">Submit</button>


<script>
    const schetable = $('#schetable');
    const searchInput = $('#search');

    function append_tr(obj) {
        const tbody = schetable.children('tbody');
        let tr = $('<tr>');

        for (const key of ['code', 'name', 'start', 'end', 'dow'])
        {
            let td = $('<td>');
    
            td.attr('code', obj['code']);
            td.text(obj[key]);

            if (key == 'code')
                td.click(del_func);

            tr.append(td);
        }
        tbody.append(tr);
    }

    function delete_tr(tr) {
        tr.remove();
    }

    function clear_table() {
        schetable.children('tbody').html('');
    }

    function del_func (event) {
        // your codes here
        var code = $(this).text();
        var obj = $(this);

        $.post(
            "sche_delete.jsp",
            {
                "code": code
            },
            function(res) {
                delete_tr($(obj).parent('tr'));
            }
        ).error(function() {
            console.log("Schedule Delete Error!");
        });
    }

    function refresh_table() {
        // your codes here
        var sText = $('#search').val();
        
        $.post(
            "sche_select.jsp",
            {
                "sText" : sText
            },
            function(res) {
                var obj = JSON.parse(res);
                clear_table();
                for(let key in obj) {
                    
                    append_tr(obj[key]);
                }
            }
        ).error(function(){
            console.log("Schedule Select Error!");
        });
    }

    // Automatically display schedules of user
    refresh_table();

    $('#search').change(refresh_table);
    
    $('#submit_btn').click(function(){
        // your codes here
        var start = $('#start').val();
        var end = $('#end').val();
        var name = $('#name').val();
        var dow = $('#dow').val();

        $.post(
            "sche_insert.jsp",
            {
                "start": start,
                "end": end,
                "name": name,
                "dow": dow
            },
            function(res) {
                var obj = JSON.parse(res);
                if(obj.code == -1) {
                    console.log("Schedule Overlapped!\n");
                    return;
                }
                    
                append_tr(obj);
            }
        ).error(function() {
            console.log("Schedule Insert Error!");
        });
    });

</script>
<%@ include file="footer.jsp" %>