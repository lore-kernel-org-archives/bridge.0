From: Gerard Borg <ggb112@rsphy1.anu.edu.au>
Message-ID: <4346.203.214.64.233.1090148614.squirrel@rsphyweb.anu.edu.au>
Date: Sun, 18 Jul 2004 21:03:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Ethernet network driver
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi all

I am trying to bridge an ethernet card to mkiss.c which implements the
ax25 protocol for serial ttys. I have had trouble getting this to work and
I have a few general questions...
(i) Would one expect ax25's acknowledgement to cause trouble with
forwarding non-source ip packets like the wlan firmware is reputed to(And in so doing make bridging impossible).

(ii) If one were to write a device driver for the serial port that does the
KISS procotol without ax25 at all (ie imitate Ethernet and use  line
disciplines to talk to the serial port but avoid ax25), then is there a
format or model on which  to base such a driver?
For example, the driver SNULL in Alessandro Rubini's book on LINUX DEVICE
DRIVERS is said to be Ethernet compatible and is generally available in
source.
What about PLIP? Maybe I could model the driver on PLIP which is Ethernet
compatible?

Gerard


