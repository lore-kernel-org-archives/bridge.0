Return-Path: <jochen.dehm@freenet.de>
Message-ID: <53C162B9.4070501@freenet.de>
From: Jochen Dehm <jochen.dehm@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] parallel bridging?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sat, 12 Jul 2014 16:54:53 -0000
To: bridge@lists.linux-foundation.org

Hi there,

i have 2 locations, connected via telephone cable. Both locations are 
connected via two dsl bridges.
Everything works fine.

Now i have to increase the bandwith and want to build the following 
szenario:

                   Port 1/g1 ------ dsl bridge 1a ------- dsl bridge 2a 
----- Port 2/g1
/ \
switch1 switch2
\ /
                   Port 1/g2 ------ dsl bridge 1b ------- dsl bridge 2b 
----- Port 2/g2

Building two etherchannels (LACP) 1/g1 with 1/g2 and 2/g1 with 2/g2 
won't work, i guess the dsl bridge didn't transport LACP packets.

RSTP won't fit my needs, increasing the bandwith.

Does anyone have an idea, how to solve the problem?
Do the dsl bridges need specific characteristics?

regards
joed


