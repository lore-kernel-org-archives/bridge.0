Date: Wed, 16 Mar 2005 19:15:32 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20050316181532.GA3251@stusta.de>
References: <20050315121930.GE3189@stusta.de>
	<200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
Subject: [Bridge] Re: [2.6 patch] fix bridge <-> ATM compile error
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: chas3@users.sourceforge.net
Cc: netdev@oss.sgi.com, linux-atm-general@lists.sourceforge.net, bridge@osdl.org, linux-kernel@vger.kernel.org, shemminger@osdl.org

On Wed, Mar 16, 2005 at 11:11:29AM -0500, chas williams - CONTRACTOR wrote:
> In message <20050315121930.GE3189@stusta.de>,Adrian Bunk writes:
> >This patch fixes the following compile error with CONFIG_BRIDGE=y and 
> >CONFIG_ATM_LANE=m:
> 
> isnt the problem more that CONFIG_ATM=m not CONFIG_ATM_LANE=m?
> perhaps CONFIG_BRIDGE should be dependent on CONFIG_ATM.  if
> atm is a module then bridge cannot be a module (unless the 
> hooks are moved from atm to bridge)?

The problem is currently CONFIG_ATM_LANE due to the #ifdef's in 
net/atm/common.c .

Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
idea, since I doubt all people using the Bridge code require ATM 
support.

Moving the hooks to the bridge code will give you exactly the same 
problems the other way round.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

