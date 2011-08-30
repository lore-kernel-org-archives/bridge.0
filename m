From: Joe Perches <joe@perches.com>
In-Reply-To: <4E5CDBAA.6040001@trash.net>
References: <cover.1314650069.git.joe@perches.com>
	<13c1c12486cae409dfa5254b1435e660f2b17e05.1314650069.git.joe@perches.com>
	<4E5CDBAA.6040001@trash.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 09:13:38 -0700
Message-ID: <1314720818.14422.1.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 06/24] netfilter: Remove unnecessary OOM
 logging messages
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: Wensong Zhang <wensong@linux-vs.org>, netfilter@vger.kernel.org, coreteam@netfilter.org, Simon Horman <horms@verge.net.au>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S.
	Miller" <davem@davemloft.net>

On Tue, 2011-08-30 at 14:46 +0200, Patrick McHardy wrote:
> On 29.08.2011 23:17, Joe Perches wrote:
> > Removing unnecessary messages saves code and text.
> > Site specific OOM messages are duplications of a generic MM
> > out of memory message and aren't really useful, so just
> > delete them.
> Looks good to me. Do you want me to apply this patch or are you
> intending to have the entire series go through Dave?

It doesn't matter to me one way or another.

If you pick this one up, when I redo these
to separate vmalloc from the the other alloc
cases, I'll won't send netfilter again.

cheers, Joe

