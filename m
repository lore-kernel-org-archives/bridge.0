Return-Path: <prvs=160294ebed=f.cappelletti@selta.it>
Message-ID: <50505129.9010005@selta.it>
Date: Wed, 12 Sep 2012 11:08:57 +0200
From: Cappelletti Fabio <f.cappelletti@selta.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Rstp proposal and agreement bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all, I'm using rstpd in my machine, but I have a problem with 
mangement of BPDU with proposal and agreement flags.
In particular I see that rstp deamon don't manage correctly this flags 
when a topology change occurred in the network; proposal flag is not set 
when my bridge communicate the new root bridge and agreement bit is not 
set to ack a proposal BPDU.
Coul'd someone help me?

BR,
Fabio
