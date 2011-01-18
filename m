Message-ID: <4D356B14.6050501@atpss.net>
Date: Tue, 18 Jan 2011 11:27:32 +0100
From: Claudio Prono <claudio.prono@atpss.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Linux Firewall with STP
Reply-To: claudio.prono@atpss.net
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello all,

I don't have a big experience with stp protocol, so i need some help on
configuration.

My scenario is the following:

I have one (ore more) system behind two redundat switches. The system
have 2 ethernet cards, so it is connected with the two switches, and the
switches are connected each other. connected to the two switches there
is a linux firewall, with 3 ethernet cards. Two are connected to the
switches, the last one is connected to the internet router.

There is my questions:

- The system behind the two redundant switches must have 2 IP Address?
One for each card?
- The Firewall must have 2 "Internal" IP addresses? And if yes, how i
can NAT this to an external address?

Anyone have experence in scenarios like this and can help me for a
correct configuration?

Any type of help is well accepted.

Thanks,

Claudio Prono.

-- 
--------------------------------------------------------------------------------
Claudio Prono                         OPST
System Developer               
                                      Gsm: +39-349-54.33.258
@PSS Srl                              Tel: +39-011-32.72.100
Via San Bernardino, 17                Fax: +39-011-32.46.497
10141 Torino - ITALY                  http://atpss.net/disclaimer
--------------------------------------------------------------------------------
PGP Key - http://keys.atpss.net/c_prono.asc




