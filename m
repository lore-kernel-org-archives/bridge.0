Date: Tue, 30 Aug 2011 13:55:02 -0400 (EDT)
Message-Id: <20110830.135502.179848097213434762.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4E5CDBAA.6040001@trash.net>
References: <cover.1314650069.git.joe@perches.com>
	<13c1c12486cae409dfa5254b1435e660f2b17e05.1314650069.git.joe@perches.com>
	<4E5CDBAA.6040001@trash.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: kaber@trash.net
Cc: wensong@linux-vs.org, netfilter@vger.kernel.org, coreteam@netfilter.org, horms@verge.net.au, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org, ja@ssi.bg, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, joe@perches.com, kuznet@ms2.inr.ac.ru

From: Patrick McHardy <kaber@trash.net>
Date: Tue, 30 Aug 2011 14:46:34 +0200

> On 29.08.2011 23:17, Joe Perches wrote:
>> Removing unnecessary messages saves code and text.
>> 
>> Site specific OOM messages are duplications of a generic MM
>> out of memory message and aren't really useful, so just
>> delete them.
> 
> Looks good to me. Do you want me to apply this patch or are you
> intending to have the entire series go through Dave?

I'm happy with subsystem folks taking things in if they want, the
B.A.T.M.A.N. guys did this earlier today for example.
