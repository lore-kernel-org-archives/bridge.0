Date: Wed, 28 Jul 2004 19:13:15 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] Assertion failed in bridge code on 2.4.27-rc3
Message-Id: <20040728191315.58252730.davem@redhat.com>
In-Reply-To: <20040728162802.6a297248@dell_ss3.pdx.osdl.net>
References: <20040728195957.GA2621@man.manty.net>
	<20040728132128.22bed751@dell_ss3.pdx.osdl.net>
	<20040728222722.GA2688@man.manty.net>
	<20040728162802.6a297248@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: manty@manty.net, bridge@lists.osdl.org

On Wed, 28 Jul 2004 16:28:02 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The code path for some ioctl's is different in 2.4 than 2.6 (it goes
> through IP in 2.4).  Therefore the following is needed.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Thanks for fixing this so quickly Stephen.

Applied.
