Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Tue, 19 Jun 2012 10:48:09 +0300
References: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
	<CAOJFanURN8_LfYLWHFEtACc9_8mNb1vZ=mENnNR=0v6ZXTk=Tg@mail.gmail.com>
	<20120618135450.27473585@nehalam.linuxnetplumber.net>
In-Reply-To: <20120618135450.27473585@nehalam.linuxnetplumber.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201206191048.10023.vitas@nppfactor.kiev.ua>
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
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

On Monday 18 June 2012 23:54:50 Stephen Hemminger wrote:
>
> First off, STP is not a secure protocol. It assumes a trust in any bridge
> it excepts PDU's from. That is why Cisco as bpdu guard to ignore stuff
> from rogue endpoints. In Linux, you can do the same with netfilter but
> most users dont.
>
> Second, the standard (Linux is based on old 1998 version) allows any
> value for forwarding delay (0 .. 255 seconds). The encoding of timer
> value section implies that.
>

Hello, Stephen!
Standards (both -1998 and -2004 revisions) do say nothing about validation of 
timers (except one issue) and you gave a good point that encoding clearly 
allows any timer value from 0.0 s to 255+255/256 s.

Now, to the exceptional issue:
9.3.3 a) of -1998 (9.3.4 a) of -2004)
===============================================
a) The BPDU Type denotes a Configuration BPDU and the BPDU contains at least 
35 octets, and the value of the BPDUs Message Age parameter is less than that 
of its Max Age parameter ... [skip]
===============================================

So, the standard clearly requires the BPDU where MessageAge < MaxAge to be 
dropped.

Don't you think that including this check in Linux bridging code is 
worthwhile?

-- 
With Best Regards,
Vitalii Demianets
