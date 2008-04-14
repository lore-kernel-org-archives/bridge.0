Date: Mon, 14 Apr 2008 12:13:29 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080414121329.3ba292af@extreme>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32FA1BE@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32FA1BE@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] default values
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge@lists.osdl.org

On Mon, 14 Apr 2008 14:43:38 +1000
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi all, 
> Can anybody tell me what the default values for setageingtimer and
> setgcint are?
>  
>  
> Regards,
>              Leigh
>  
> Leigh Sharpe
> Network Systems Engineer
> Pacific Wireless
> Ph +61 3 9584 8966
> Mob 0408 009 502
> Helpdesk 1300 300 616
> email lsharpe@pacificwireless.com.au
> <blocked::mailto:lsharpe@pacificwireless.com.au> 
> web www.pacificwireless.com.au
> <blocked::http://www.pacificwireless.com.au/> 
>  

ageing_time = 300 sec (5min)

GC interval in recent kernels is not constant, but goes off
as soon as the next entry would expire. This is done to avoid
getting large forwarding table build up during a DoS attack.
