Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <CACyobKnP5mrx5sW9bKt3PQsQib6+VCXArMdBCRXHd4vo3qMHqw@mail.gmail.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <56EB5D9E.2060704@lab.ntt.co.jp>
Date: Fri, 18 Mar 2016 10:45:02 +0900
MIME-Version: 1.0
In-Reply-To: <CACyobKnP5mrx5sW9bKt3PQsQib6+VCXArMdBCRXHd4vo3qMHqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] DEI Bit Behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy <paleopoe@gmail.com>, bridge@lists.linux-foundation.org

On 2016/03/16 6:50, Andy wrote:
> Hello Community,

Hi,

> 
> I've been working on a project that requires a very simple setup:
> 
>  
> 
> Packet Generator ---> ETH0 --- Bridge --- ETH1 ---> Packet Capture
> 
>  
> 
> What I want to see are packets going through my setup unmodified but
> instead I'm seeing an interesting behavior when I send QnQ Ethernet traffic.
> 
> While sending double tagged packets, I’ve noticed that the DEI bit in
> the VLAN tag is getting reset to zero.  This only happens if my SVLAN
> tag uses the TPID value 0x88A8 or 0x8100. If I use a non-standard TPID
> like 0x9100, the value of the DEI bit is passed through the system
> unmodified (as desired).
> 
>  
> 
> To be honest, I'm not sure if this is intentional or unexpected but I've
> done a lot of investigating and everything seems to imply that packets
> should not be modified as it goes through the setup.
> 
>  
> 
> I have run my experiment on multiple devices, different interfaces and
> different Linux distributions/Kernels.
> 
> As far as I can tell, the behavior seems consistent.
> 
>  
> 
> Is the resetting of the DEI bit intentional (seeing how it is not reset
> when I pass a non-standard TPID, kind of makes me think it is)? If so, why?

This is limitation in current linux vlan support.
Historically, DEI used to be CFI and CFI was not used in Ethernet, and
kernel has reused CFI bit for another usage (for indicating the presence
of a HW accelerated vlan tag).

Now 802.1ad and later versions of 802.1q spec have replaced CFI with
DEI, but kernel implementation has not been changed so far. So, we are
using that field in different way and always clears the bit on sending
packets out.

Non-standard TPID is not supported in linux bridge's vlan_filtering or
vlan device, so those headers are not touched in packet processing in
kernel.

> 
> Is there a way to prevent this from happening?

AFAIK, there is no way. vlan tags are always parsed by kernel and DEI is
cleared...

Regards,
Toshiaki Makita


