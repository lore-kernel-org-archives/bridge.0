Return-Path: <Holger.Brunck@keymile.com>
Message-ID: <4EC6234A.1030002@keymile.com>
From: Holger Brunck <holger.brunck@keymile.com>
MIME-Version: 1.0
References: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com><20111114.003702.1097206603722725705.davem@davemloft.net><1321254211.4072.29.camel@pc005091.de.keymile.net><20111114.020749.1176229013272872343.davem@davemloft.net>
	<20111117192353.GD2051622@jupiter.n2.diac24.net>
In-Reply-To: <20111117192353.GD2051622@jupiter.n2.diac24.net>
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net,
	bridge: print log message after state changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 18 Nov 2011 09:30:31 -0000
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On 11/17/2011 08:23 PM, David Lamparter wrote:
> On Mon, Nov 14, 2011 at 02:07:49AM -0500, David Miller wrote:
>>>> The message is therefore appropriately timed as far as I'm concerned.
>>>>
>>>
>>> It's not.
>>>
>>> Please test: create a bridge with STP disabled, add an interface to the
>>> bridge and set that interface down. You get the message "... entering
>>> forwarding state". That's wrong because it's "about to enter" disabled
>>> state some lines later.
>>>
>>> All other (4) calls to br_log_state are located after the state change,
>>> see for example br_stp_enable_port() just some lines above the patch.
>>
>> I would never expect an "entering" message to print out after the event
>> happens, and in fact I'd _always_ want to see it beforehand so that if
>> the state change caused a crash or similar it'd be that much easier
>> to pinpoint the proper location.
> 
> There seems to be a misunderstanding here. The patch effectively does:
> -       br_log_state(p);
>         p->state = BR_STATE_DISABLED;
> +       br_log_state(p);
> 
> and the issue it is trying to fix is not the timing but rather the code
> printing the wrong (old, now-left) state.
> 

Yes exactly this is the problem. We got confusing state messages in the current
implementation.

> I do agree that the log message should be printed before anything
> happens, so, Holger, can you brew a patch that does that?
> 

This can't be changed easily. Because in some situations we don't know which
state we will enter at the entry point of the function.

For example  br_make_forwarding does something like
if ..
  p->state = STATE_A
else if ...
  p->state = STATE_B
....

So my approach would be to change the log message from "port entering state" to
"port entered state" and print it out after the state changed.

Regards
Holger


