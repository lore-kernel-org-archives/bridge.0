Message-ID: <1446.80.133.183.165.1093363782.squirrel@80.133.183.165>
Date: Tue, 24 Aug 2004 18:09:42 +0200 (CEST)
Subject: Re: [Bridge] Encrypting Bridge?
From: "Rene Bartsch" <ML@Bartschnet.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Di, 24.08.2004, 17:36, Josh Wyatt sagte:

>> tunnel at layer 2 can be really useful when it comes to bandwidth
and/or latency matters.
>>
>
> There is already a tool to do layer-2 bridging with encryption.  Check
out vtun:
>
> http://vtun.sourceforge.net/
>
> I use it a great deal to do layer-2 bridging.  It works with the kernel
tun/tap
> driver and works very well.  It can use TCP or UDP as the transport, offers
> compression, etc.  Key management is up to you, however.
>

As it uses tun/tap I assume compression/encryption is done in user-space,
which means increased latency (I want to use it von IP/Video-telephony).

As VIA claims the PadLock function of the Nehemia cores achieves 12,5
GBit/s with AES at 1 GHz CPU speed and a TDP of 7 Watts, using a
encryption in kernel-space with the PadLock function would mean that you
can en-/decrypt several 100 MBit/s tunnels with a 200,- EUR ITX-machine -
without big latency!

Rene



