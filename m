MIME-Version: 1.0
Date: Mon, 11 May 2009 10:04:29 -0400
Message-ID: <e6e2252e0905110704o68fcf603v3a4e563d3cf2093b@mail.gmail.com>
From: Andrew Watts <systemstalker@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Configuring a PPP Half Bridge/IP Passthru
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

Im trying to create a PPP Half-Bridge/ZIPB/IP-Passthru so that I can
pass through my public IP address to a device connected to the
Ethernet interface of a device that uses a 3G modem for connectivity.
This product exists but I want to do it with my own hardware.  I have
an NSLU2 that I have connected to a 3G cellular into the USB port, I
then want to take the IP address from the resulting PPP and give it to
an embedded device so that it has a publicly routable IP address that
can be accessed directly.  Cradlepoint has such a device, I want to do
the exact same thing just with Linux :).  The link below explains what
I am try to do as well including the product in question.  I cant
bridge a PPP interface to an Ethernet interface, if I had to do that
where would I start to make modifications to the kernel?

http://store.drwireless.com/crceippabrad.html

Anyone have any Idea how I might do that?
