Message-ID: <4AFC30D8.4050506@trash.net>
Date: Thu, 12 Nov 2009 16:59:20 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20091110222632.24100.14884.stgit@mimic.site>
	<4AFC2D65.9040903@gmail.com> <4AFC2F71.1060408@trash.net>
	<4AFC2FCC.5090103@gmail.com>
In-Reply-To: <4AFC2FCC.5090103@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/4] vbus: venet macvlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, Patrick Mullaney <pmullaney@novell.com>, evb@yahoogroups.com

Gregory Haskins wrote:
> Patrick McHardy wrote:
>> Gregory Haskins wrote:
>>> Patrick Mullaney wrote:
>>>> (Applies to alacrityvm.git/master:34534534)
>>>>
>>>> This patchset implements a vbus venet device with a
>>>> macvlan backend.
>>> Thanks Pat, applied.
>> As I mentioned in my response to these patches, the macvlan part
>> need more work.
> 
> Yeah, I talked to Pat offline.  He is going to patch it incrementally as
> its not a trivial problem to cleanup.  For the time being, they are
> sitting in the alacrityvm tree, but they are not going upstream until
> the macvlan stuff is resolved.

I see, thanks.
