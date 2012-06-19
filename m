Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Tue, 19 Jun 2012 11:16:50 +0300
References: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
	<201206191048.10023.vitas@nppfactor.kiev.ua>
	<CAOJFanXztn4LMSLyqDH5zPBKXHKGztiSQPZmcSQ-4Px7zV54Bg@mail.gmail.com>
In-Reply-To: <CAOJFanXztn4LMSLyqDH5zPBKXHKGztiSQPZmcSQ-4Px7zV54Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201206191116.50606.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
	point of view
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sasikanth babu <sasikanth.v19@gmail.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

On Tuesday 19 June 2012 10:54:13 Sasikanth babu wrote:
> >
> > Don't you think that including this check in Linux bridging code is
> > worthwhile?
> >
> >   Are you talking about this check (in function br_stp_rcv)?
>
>                 if (bpdu.message_age > bpdu.max_age) {
>                         if (net_ratelimit())
>                                 br_notice(p->br,
>                                           "port %u config from %pM"
>                                           " (message_age %ul > max_age
> %ul)\n",
>                                           p->port_no,
>                                           eth_hdr(skb)->h_source,
>                                           bpdu.message_age, bpdu.max_age);
>                         goto out;
>                 }
>

Oh, yes, thank you for pointing that out. I was clearly looking at the 
outdated code.

-- 
With Best Regards,
Vitalii Demianets
