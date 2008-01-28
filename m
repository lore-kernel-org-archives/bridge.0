From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Mon, 28 Jan 2008 21:29:53 +0100
Message-ID: <m37ihtelry.fsf@ursa.amorsen.dk>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: news <news@ger.gmane.org>
Subject: [Bridge] Re: [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Jaime Medrano <jaime.medrano@gmail.com> writes:

> Below is a new patch that handles the double-tagging case. I'm not sure
> if it is worth a more generic case. ¿Are triple-tagging and so really used?

Yes. The company I work for doesn't do it with Linux right now,
because double tagging is problematic enough already, but it would be
great if we could.

We're getting lots of layer-2 connections to many locations through
one provider, and each connection is double-tagged by the provider
when delivered to the central "office" (in order to make it possible
to have more than 4096 locations). We'd like to be able to deliver
more than one VLAN to each location, and that requires triple-tagging.
Do the same with two providers -- welcome to quadruple-tagging.


/Benny


