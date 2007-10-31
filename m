Date: Wed, 31 Oct 2007 15:08:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Lowering CPU utilisation
Message-ID: <20071031150819.082f46c1@freepuppy.rosehill>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32D14@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32D14@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.linux-foundation.org

On Thu, 1 Nov 2007 09:00:07 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All, 
>  I have a box with 12 bridges on it, each of which has 2 ports.
> When the traffic level on the box reaches around 15-20Mbps on each
> bridge, my CPU utilisation gets to about 90-95%.
> I would like to avoid working the CPU that hard. Is there anything which
> can be done to get the CPU utlilisation down a bit? I have plans for an
> even bigger bridge, but these results indicate that it may not scale
> quite that well.
>  
> Regards,
>              Leigh
>  
>  

Learn how to use oprofile and figure out where the time is going.
You might be getting hit by the choice of network interface.


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
