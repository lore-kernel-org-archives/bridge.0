Return-Path: <advax@triumf.ca>
Date: Tue, 31 Jan 2012 13:28:52 -0800 (PST)
From: Andrew Daviel <advax@triumf.ca>
Message-ID: <Pine.LNX.4.64.1201311317240.31605@andrew.triumf.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] Kernel tuning for bridge machines
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


We are running a Linux box with 10g interfaces as a bridging firewall.

We have mostly long-distance TCP data transfers, but also some real-time 
traffic (video, voice)

I've read conflicting suggestions on how to tune kernel parameters - up 
for data, or down for VoIP, but those are mainly aimed at endpoints.

Are there any recommendations for tuning for a bridge ?

refs.
http://fasterdata.es.net/fasterdata/host-tuning/linux/
http://www.bufferbloat.net
http://wiki.freeswitch.org/wiki/Performance_testing_and_configurations


-- 
Andrew Daviel, TRIUMF, Canada
Tel. +1 (604) 222-7376  (Pacific Time)
