DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
	bh=u+3B6xOOTZts88Cu2/q3rUjWank7OvIq8gjDasf1j0E=;
	b=bZiXNjZ9EBbOXjmJ9QC1SHIQn1d2N4SaBjq/z7gAGHsCcJDIQHnnLYSJ9S8t5F9oq7thQKkUFidTmN9Zq9WWAi2vMiu0oAOFflMBZZP505q+J6SNmm9K0Ho6osojzB7LNU+h0P47bNfHEx3JZebbWMFfQCqvY3X6JY2OBfmwh/E=
Message-ID: <71e4505a0802040455v519fae8aieed95a0fa3ba6372@mail.gmail.com>
Date: Mon, 4 Feb 2008 13:55:27 +0100
From: "Spigao spigao" <spigao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5755_29257137.1202129727416"
Subject: [Bridge] Bridge two tun/tap interfaces and keep their IP address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_5755_29257137.1202129727416
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

I am new in this mailing list and quite new with the brctl too; so, I'm
sorry if this is a very obvious or absurd question.


I am performing network emulations, with a very particular emulator that
uses tap devices. Also, I want to run UML virtual machines as if they are
binded to those tap device. But it is not possible to use the same tap,
because the network emulator doesn't allow UML to access it (the emulator
manages the file descriptor of the tap). So, I am thinking on building a
bridge with two virtual interfaces, one for the emulator and one for the
UML.

The problem is that I can't manage to build a bridge joining the two tap
interfaces, which also should keep their IP address. The reason why they
should keep it is that in the emulator tap, a routing daemon must take the
IP address from the interface; so, if I change it to 0.0.0.0, it doesn't
work properly.

Until now, the interfaces only receive some of the packets, the bridge is
not completely transparent.

In other words, what I need is two tap interfaces working as one, is it
possible? how would you do it?


Best regards,
Sergio

------=_Part_5755_29257137.1202129727416
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,<br><br>I am new in this mailing list and quite new with the brctl too; so, I&#39;m sorry if this is a very obvious or absurd question.<br><br><br>I am performing network emulations, with a very particular emulator that uses tap devices. Also, I want to run UML virtual machines as if they are binded to those tap device. But it is not possible to use the same tap, because the network emulator doesn&#39;t allow UML to access it (the emulator manages the file descriptor of the tap). So, I am thinking on building a bridge with two virtual interfaces, one for the emulator and one for the UML.<br>
<br>The problem is that I can&#39;t manage to build a bridge joining the two tap interfaces, which also should keep their IP address. The reason why they should keep it is that in the emulator tap, a routing daemon must take the IP address from the interface; so, if I change it to <a href="http://0.0.0.0">0.0.0.0</a>, it doesn&#39;t work properly.<br>
<br>Until now, the interfaces only receive some of the packets, the bridge is not completely transparent.<br><br>In other words, what I need is two tap interfaces working as one, is it possible? how would you do it?<br><br>
<br>Best regards,<br>Sergio<br>

------=_Part_5755_29257137.1202129727416--
