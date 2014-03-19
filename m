Return-Path: <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <5328ED25.1040900@lab.ntt.co.jp>
Date: Wed, 19 Mar 2014 10:04:37 +0900
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
References: <1394680527-28970-1-git-send-email-mcgrof@do-not-panic.com>
	<1394680527-28970-2-git-send-email-mcgrof@do-not-panic.com>
	<5328E802.3030901@lab.ntt.co.jp>
	<CAB=NE6X2eZFLWBN1acf=d75T_K2YM_OK3oaXEPu-hwpUJEmwkg@mail.gmail.com>
In-Reply-To: <CAB=NE6X2eZFLWBN1acf=d75T_K2YM_OK3oaXEPu-hwpUJEmwkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] bridge: preserve random init MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

(2014/03/19 9:50), Luis R. Rodriguez wrote:
> On Tue, Mar 18, 2014 at 5:42 PM, Toshiaki Makita
> <makita.toshiaki@lab.ntt.co.jp> wrote:
>> nit,
>> If the last detached port happens to have the same addr as
>> random_init_addr, this seems to call br_stp_change_bridge_id() even
>> though bridge_id is not changed.
> 
> Ah good point.
> 
>> Shouldn't the assignment of random_init_addr be done before the check of
>> "no change"?
> 
> Good question, should we even allow two ports to have the same MAC
> address or should we complain and refuse to add it? If so that should
> mean we should also have to monitor any manual address changes or
> events for address changes on the ports.

This was recently discussed by Stephen and me.
I'm thinking it should be allowed.

http://marc.info/?l=linux-netdev&m=139182743919257&w=2

Toshiaki Makita

> 
> Stephen?
> 
>   Luis
