Date: Mon, 28 Mar 2005 11:11:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050328111131.2f511a85@dxpl.pdx.osdl.net>
In-Reply-To: <20050319230458.GB18495@stusta.de>
References: <20050316181532.GA3251@stusta.de>
	<200503172036.j2HKadfm000732@ginger.cmf.nrl.navy.mil>
	<20050319230458.GB18495@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [2.6 patch] fix bridge <-> ATM compile error
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-atm-general@lists.sourceforge.net, bridge@osdl.org, linux-kernel@vger.kernel.org, chas3@users.sourceforge.net

On Sun, 20 Mar 2005 00:04:58 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Mar 17, 2005 at 03:36:40PM -0500, chas williams - CONTRACTOR wrote:
> > In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
> > >Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
> > >idea, since I doubt all people using the Bridge code require ATM 
> > >support.
> > 
> > how about the following?
> >...
> 
> Looks good

Ditto
