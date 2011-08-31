Message-ID: <4E5E092E.80507@trash.net>
Date: Wed, 31 Aug 2011 12:13:02 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <cover.1314650069.git.joe@perches.com>	<13c1c12486cae409dfa5254b1435e660f2b17e05.1314650069.git.joe@perches.com>	<4E5CDBAA.6040001@trash.net>
	<20110830.135502.179848097213434762.davem@davemloft.net>
In-Reply-To: <20110830.135502.179848097213434762.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: wensong@linux-vs.org, netfilter@vger.kernel.org, coreteam@netfilter.org, horms@verge.net.au, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org, ja@ssi.bg, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, joe@perches.com, kuznet@ms2.inr.ac.ru

On 30.08.2011 19:55, David Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Tue, 30 Aug 2011 14:46:34 +0200
> 
>> On 29.08.2011 23:17, Joe Perches wrote:
>>> Removing unnecessary messages saves code and text.
>>>
>>> Site specific OOM messages are duplications of a generic MM
>>> out of memory message and aren't really useful, so just
>>> delete them.
>>
>> Looks good to me. Do you want me to apply this patch or are you
>> intending to have the entire series go through Dave?
> 
> I'm happy with subsystem folks taking things in if they want, the
> B.A.T.M.A.N. guys did this earlier today for example.

OK, thanks.

Applied after fixing up some minor rejects in nf_nat_snmp_basic.c,
thanks Joe.
