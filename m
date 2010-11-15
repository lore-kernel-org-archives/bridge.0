From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <201011152123.HHB21896.HFOOVSMFOtLJQF@I-love.SAKURA.ne.jp>
References: <20101114211201.678755903@vyatta.com>
	<201011152123.HHB21896.HFOOVSMFOtLJQF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 15 Nov 2010 14:33:07 +0100
Message-ID: <1289827987.2607.50.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH 0/5] bridge: RCU annotation and cleanup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Le lundi 15 novembre 2010 à 21:23 +0900, Tetsuo Handa a écrit :
> Stephen Hemminger wrote:
> > This is a split up of what Eric did with a couple of small changes and additions.
> Something seems to be wrong with this patchset.
> 
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> > @@ -173,8 +177,8 @@ forward:
> >  	switch (p->state) {
> >  	case BR_STATE_FORWARDING:
> >  		rhook = rcu_dereference(br_should_route_hook);
> > -		if (rhook != NULL) {
> > -			if (rhook(skb))
> > +		if (rhook) {
> > +			if ((*rhook)(skb))
> 
> Is *rhook != NULL guaranteed when rhook != NULL?

Its the C standard convention, we call function pointed by rhook, not
*rhook.

$ cat func.c
typedef int (*hook_t)(int a1, int a2);

hook_t *hook;

int foo(int a1, int a2)
{
hook_t *handler = hook;

	if (handler)
		return handler(a1, a2);
	return 0;
}
$ gcc -O2 -c func.c
func.c: In function ‘foo’:
func.c:10:17: error: called object ‘handler’ is not a function


Now, if we use (*handler), it works :

$ cat func.c
typedef int (*hook_t)(int a1, int a2);

hook_t *hook;

int foo(int a1, int a2)
{
hook_t *handler = hook;

	if (handler)
		return (*handler)(a1, a2);
	return 0;
}
$ gcc -O2 -c func.c
$



