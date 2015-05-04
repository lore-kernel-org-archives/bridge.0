Return-Path: <ratheesh.ksz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=s8drjD8+zHMpDARZeBJFVFVqeCsUNWgfgAvsxLmYh/w=;
	b=uIcPmgsy0hUlrhlFfZNjlwQYZBtFRD/D3jl9GE2D39QoKokyjj5LycXMKamfhp4Iqv
	x5Si7Mj1Q1t+PTuMMuouno7WlhX9m35xCVOyjPfD+E0HbIsBdRQky/V2wkjlOsO9eBEU
	0q6PB2uXeRVEcPBG4Esz8yOFiSVLY0j2SPvj1qwLK2Cn9XgovooIAzZ49eFXdKlPeFMT
	mrVSNhFRAZ7cO35SfXuO8Q3FWBOVdWkqmPm7O9M30dBikse/P3DsApw2S/zWCHs9SdUb
	eSelWR/AUggGck2wxoln6CPx7hA5NQythCxwXZkZJDj/kloRl0vx7uedkw3eegJ4o79V
	LiNg==
MIME-Version: 1.0
Date: Mon, 4 May 2015 15:34:17 +0530
Message-ID: <CAGZFCEHrB5awRa4qaMgwriW_x9qXOMUjG-Nom+aWQ_TWXA040Q@mail.gmail.com>
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Bridge] linux brigde query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

             br0
              |
--------------------------------------------
 |                   |                   |
eth0              eth1             eth2
 |                                        |
Machine A                       machine B

suppose there is a UDP bidirectional traffic between machine A and B.
Then there will be bridge port
info in "brctl showmacs br0"  command output. After some time, UDP
traffic becomes only uni directional( say
only from machine A to B , there is no traffic from B to A ). Then
before bridge ages out , B got removed ; but link eth2
is not going down ( no link down message at eth2, it can be achieved
if  eth2 to a harware switch , and machine
was connected to one port of that switch ). Then traffic will flood or
will black hole till ageing timer expire.


As from code , i can see that br_handle_frame_finish() will call
br_forward() as there is an fdb entry. right ?  so traffic will black
hole ?!!

Thanks,
Ratheesh
