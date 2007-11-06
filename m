Date: Tue, 6 Nov 2007 14:18:31 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Lowering CPU utilisation
Message-ID: <20071106141831.0fcaf76e@freepuppy.rosehill>
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32D23@exchange.pacwire.local>
References: <96CF49BD8B56384395D698BA99007FA32D23@exchange.pacwire.local>
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

On Wed, 7 Nov 2007 08:51:41 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> I'm using e1000 cards.
> According to oprofile, around 50% of the time is spent in the e1000
> driver. 
> Given that my load average is still under 0.5, I suspect I've got plenty
> of room for the driver to handle more traffic before I need to worry too
> much.
>  
>
Did you remember to configure NAPI for the e1000 driver (it is optional).

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
