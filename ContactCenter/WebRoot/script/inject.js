/*

  @param funcObj the original function to be injected.

  @param before  this is called before the execution of the funcObj.

                 you must return the arguments(new Arguments(arguments)) if you want modify the arguments value of the funcObj.

                 it will stop the execution of the funcObj if you return a value not an Arguments object nor a undefined value

  @param after   this is called after the execution of the funcObj.

                 you must add a result argument at the last argument of the aAtferExec function if you want get the result value of the funcObj.

                 you must add a denied argument following the result argument if you want know whether the funcObj is executed.

                 you must return the result if you want modify the result value of the funcObj .

*/

function Arguments(args) {

    //convert arguments object to array

    this.value = [].slice.call(args);

}

 

function Inject( funcObj, before, after ) {

    return function() {

        var result, denied=false, args=[].slice.call(arguments);

        if (typeof(before) == 'function') {

            result = before.apply(this, args);
            
            if(result == 'IPCC_STOP_FUNCTION')
            {
            	return;
            }

            if (result instanceof Arguments)

                args = result.value;

            else if (denied = result !== undefined)

                args.push(result)

            }

 

        if (!denied) {

            try {

                args.push(funcObj.apply(this, args));

 

            if (typeof(after) == 'function')

                result = after.apply(this, args.concat(denied));

            else

                result = undefined;

            } catch (e) {

            }

        }

 

        return (result !== undefined ? result : args.pop());

    }

}

