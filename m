Date: Wed, 9 Mar 2005 20:28:37 -0800
From: "David S. Miller" <davem@davemloft.net>
Message-Id: <20050309202837.1adca300.davem@davemloft.net>
In-Reply-To: <1108314982.4662.2.camel@localhost.localdomain>
References: <1108314982.4662.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in netfilter
	(take 2)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org, bridge@osdl.org, snort2004@mail.ru, gandalf@wlug.westbo.se, rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de, shemminger@osdl.org

On Sun, 13 Feb 2005 18:16:21 +0100
Bart De Schuymer <bdschuym@pandora.be> wrote:

> This is a second try to fix the long chain call lengths in netfilter.
> The difference with the previous patch is that I got rid of the extra
> argument. I somehow didn't see it could be done without using the 'int
> *ret2' argument.
> 
> A comment on the number of arguments to nf_hook_slow: I don't think the
> number of arguments should be decreased. For the bridge-nf code, f.e.,
> the indev argument does not equal (*pskb)->dev (this is an answer to a
> question of Rusty in the old thread).
> 
> A comment on the argument change of nf_hook_slow (sk_buff * to sk_buff
> **) and the bad influence on tail call optimization possibilities. From
> the discussion in the old thread it became clear that no tail call is
> generated for the current code. So, I don't see why this is a reason not
> to accept the patch. Furthermore, if gcc ever would become able of doing
> the current code with a tail call, it should be very easy to change the
> code back to the original. In the meantime, I think this patch is the
> best known solution.

I agree with your analysis of the situation and have applied your
patch, thanks for keeping this going Bart.
