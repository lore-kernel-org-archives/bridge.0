Message-ID: <4D594F47.8070500@trash.net>
Date: Mon, 14 Feb 2011 16:50:31 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <1297680875-11663-1-git-send-email-segoon@openwall.com>
In-Reply-To: <1297680875-11663-1-git-send-email-segoon@openwall.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: netfilter: fix information leak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: security@kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, netdev@vger.kernel.org, ebtables-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Am 14.02.2011 11:54, schrieb Vasiliy Kulikov:
> Struct tmp is copied from userspace.  It is not checked whether the "name"
> field is NULL terminated.  This may lead to buffer overflow and passing
> contents of kernel stack as a module name to try_then_request_module() and,
> consequently, to modprobe commandline.  It would be seen by all userspace
> processes.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Applied, thanks Vasiliy.
