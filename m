Message-ID: <409F16DD.2090600@web.de>
Date: Mon, 10 May 2004 07:45:01 +0200
From: Michael Renzmann <mrenzmann@web.de>
MIME-Version: 1.0
Subject: Re: [Bridge] RSTP Implementarion for Linux
References: <200405071501.48203.fmtrindade@inf.ufrgs.br>
	<20040509032323.GA19986@internetDog.org>
In-Reply-To: <20040509032323.GA19986@internetDog.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mrenzmann@web.de
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: alih@internetDog.org
Cc: Francisco Maestri Trindade <fmtrindade@inf.ufrgs.br>, bridge@lists.osdl.org

Hi.

Ali Bahar wrote:
>> Does anybody know if there is a implementation of the RSTP (Rapid 
>> Spanning Tree Protocol) for Linux, and where I could find it? Any
>> help would be appreciated.
> I saw something on freshmeat.net a while ago. AFAIK there is nothing
> in the linux kernel.

Freshmeat doesn't give any results when searching for "rstp", but sf.net
has the following project listed:

http://rstplib.sourceforge.net/

=== cut ===
The Rapid Spanning Tree Library project contains a full implementation
of IEEE 802.1w as an library with API. There is two processes, using this
library: 'bridge' & 'mngr'. First simulates RSTP bridge behavior, second
is dedicated to link/unlink 'bridges' into virtual RSTP domain (VRSTPD).
Both 'bridge' & 'mngr' has its own simple CLI like language of commands;
these commands allow to manage the VRSTPD. There are tools to trace
state machine transitions and get traps about drastic changes.

Purpose: studying, debugging, development.

The library may be used in real bridges/routers while bounding to a real
system depending environment.
=== cut ===

hth.

Bye, Mike
