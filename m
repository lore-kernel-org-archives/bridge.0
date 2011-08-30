Message-ID: <4E5CDBAA.6040001@trash.net>
Date: Tue, 30 Aug 2011 14:46:34 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <cover.1314650069.git.joe@perches.com>
	<13c1c12486cae409dfa5254b1435e660f2b17e05.1314650069.git.joe@perches.com>
In-Reply-To: <13c1c12486cae409dfa5254b1435e660f2b17e05.1314650069.git.joe@perches.com>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Joe Perches <joe@perches.com>
Cc: Wensong Zhang <wensong@linux-vs.org>, netfilter@vger.kernel.org, coreteam@netfilter.org, Simon Horman <horms@verge.net.au>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>

On 29.08.2011 23:17, Joe Perches wrote:
> Removing unnecessary messages saves code and text.
> 
> Site specific OOM messages are duplications of a generic MM
> out of memory message and aren't really useful, so just
> delete them.

Looks good to me. Do you want me to apply this patch or are you
intending to have the entire series go through Dave?
