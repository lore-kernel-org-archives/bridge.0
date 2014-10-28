Return-Path: <satyanarayanam@tataelxsi.co.in>
Message-ID: <544F4F11.5030804@tataelxsi.co.in>
Date: Tue, 28 Oct 2014 13:38:49 +0530
From: M Satyanarayana Reddy <satyanarayanam@tataelxsi.co.in>
MIME-Version: 1.0
References: <OF305789BF.DDFC2700-ONC1257D78.004C279D-C1257D78.004EAE6C@LocalDomain>
	<OF45925193.8424278E-ONC1257D7F.0027FD6A-C1257D7F.0028C7F9@neuhaus.de>
In-Reply-To: <OF45925193.8424278E-ONC1257D7F.0027FD6A-C1257D7F.0028C7F9@neuhaus.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Antwort: RSTP daemon and Marvel switch
Reply-To: satyanarayanam@tataelxsi.co.in
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oliver.Graute@neuhaus.de
Cc: bridge@lists.linux-foundation.org

Hi Oliver,

    Yes , you need DSA to distinguish from which port a frame arrived.
    DSA driver in Linux is available in below path, "drivers/net/dsa/"
  for reference " http://lxr.free-electrons.com/source/drivers/net/dsa/"

Thank you
Satya

On 10/28/2014 12:55 PM, Oliver.Graute@neuhaus.de wrote:
>
> Hello Satya,
>
>
> > RSTP daemon runs in application  and stops the kernel stp and informs
> > to pass the packets to application layer.
> > RSTP daemon waits in raw socket with stp filter.
> > You just need to change the a bit code for port wise that all.
>
> ok thanks,
>
> do I need the DSA (Distributed Switch Architecture) driver support to 
> distinguish from which port a frame arrived? Currently, I can not 
> distinguish these frames.
>
> I can't find DSA drivers in the mainline Linux Kernel for the Marvel 
> Switch Chip (88E6071) . Bur there are drivers for other DSA supported 
> chips from marvel (88E6060).
>
> Related Question:
>
> How do I customize my device tree bindings (dts file) for DSA support?
>
>
> Best regards,
>
> Oliver Graute
>

