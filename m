Return-Path: <shemminger@vyatta.com>
Date: Mon, 18 Jun 2012 13:54:50 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20120618135450.27473585@nehalam.linuxnetplumber.net>
In-Reply-To: <CAOJFanURN8_LfYLWHFEtACc9_8mNb1vZ=mENnNR=0v6ZXTk=Tg@mail.gmail.com>
References: <CAOJFanVMn4Dx+Ue1-7yS8Lk_pkVP3ra8uZcV9MQbfqOKhHq1Ng@mail.gmail.com>
	<1340012128.42375.YahooMailClassic@web121305.mail.ne1.yahoo.com>
	<CAOJFanURN8_LfYLWHFEtACc9_8mNb1vZ=mENnNR=0v6ZXTk=Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: bridge@lists.linux-foundation.org

On Mon, 18 Jun 2012 21:25:26 +0530
Sasikanth babu <sasikanth.v19@gmail.com> wrote:

> >
> > Does this implies that any value timer values present within octet 35 is
> > valid value and there is no validation done. Even if range for hello timer,
> > max age and forward delay is defined and is limited. Is it an issue or fine
> > within the standard?
> >
> >   Not all STP implementation do BPDU validations i.e validates all BPDU
> > parameters present within 35 octet. The validation checks for invalid
> > values present in the bpdu,
> >   if the BPDU validation fails it drops the BPDU. The have seen this
> > validations in proprietary software.
> >
> >
> > Please help me understand this issue and thanks for any comments.
> >
> > Regards,
> > Sujata
> >

First off, STP is not a secure protocol. It assumes a trust in any bridge
it excepts PDU's from. That is why Cisco as bpdu guard to ignore stuff
from rogue endpoints. In Linux, you can do the same with netfilter but
most users dont.

Second, the standard (Linux is based on old 1998 version) allows any
value for forwarding delay (0 .. 255 seconds). The encoding of timer
value section implies that.

There is some checks about hello vs. max age.

Much of the code in Linux seems to have come from sample code in original
standard. The standard committee decided that was too convenient and dropped
it in later revisions.
