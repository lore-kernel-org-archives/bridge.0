Message-ID: <4C226F50.4020307@free.fr>
Date: Wed, 23 Jun 2010 22:32:16 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4C223084.4080101@ll.mit.edu>
In-Reply-To: <4C223084.4080101@ll.mit.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Discrepancy in setageing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On 06/23/2010 18:04, Jeff Mitchell wrote:
> The documentation for Bridge at
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge
> says the following of setageing:
>
> ====
>
> The aging time is the number of seconds a MAC address will be
> kept in the forwarding database after having received a packet
> from this MAC address.
> The entries in the forwarding database are periodically timed out
> to ensure they won't stay around forever.
> Normally there should be no need to modify this parameter,
> but it can be changed with (time is in seconds).
>
>     # brctl setageing bridgename time
>
> Setting ageing time to zero makes all entries permanent.
>
> ====
>
> However, according to my testing, this parameter actually turns MAC
> learning off; setting it to zero simply means that entries are never
> added to the table.

Having a quick look at the code, I cannot find a special test for the value "0" for ageing_time nor 
ageing_timer. So I assume that learned macs expire right after they are learned, hence your feeling 
that mac learning is off.

Can someone double check my code revue, so we decide whether to fix the documentation or not ?

> Searching around the web reveals people with similar experiences.
>
> Is the documentation incorrect, or am I missing something?
>
> Thanks,
> Jeff
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

