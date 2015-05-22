Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <20150522031735.GB30043@gondor.apana.org.au>
References: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
	<CAHA+R7M+F88KsAJy-fGkSjUXxgBNifdML0E3r8jrQqXafZMUpA@mail.gmail.com>
	<20150522031735.GB30043@gondor.apana.org.au>
Date: Thu, 21 May 2015 20:27:42 -0700
Message-ID: <CAHA+R7OgButqv=34MRjQJ2HDHBys2Zrh4JUfgqWeg31qJ+5sFA@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, May 21, 2015 at 8:17 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, May 21, 2015 at 08:11:32PM -0700, Cong Wang wrote:
>>
>> For me it looks like we do use p->rlist in BH context, but I could easily
>> miss something here.
>
> Because the caller disables BH for us.
>


Right, I thought port attr setting uses the same way with br attr setting.
