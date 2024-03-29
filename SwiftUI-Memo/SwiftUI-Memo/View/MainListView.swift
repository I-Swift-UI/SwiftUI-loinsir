//
//  MainListView.swift
//  SwiftUI-Memo
//
//  Created by 김인환 on 2023/01/31.
//

import SwiftUI

struct MainListView: View {
    
    @EnvironmentObject var memoGroup: MemoGroup

    var body: some View {
        NavigationView {
            List(memoGroup.list) { memo in
                NavigationLink {
                    MemoEditView(memo: memo)
                        .environmentObject(memoGroup)
                } label: {
                    MemoCellView(memo: memo)
                }
            }
            .navigationTitle("Memo")
            .headerProminence(.increased)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    NavigationLink {
                        MemoEditView(memo: Memo(content: ""),
                                     isNew: true)
                            .environmentObject(memoGroup)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .renderingMode(.template)
                            .foregroundColor(.yellow)
                    }
                    .simultaneousGesture(TapGesture().onEnded ({ _ in
                        memoGroup.list.insert(Memo(content: "새로운 메모"), at: 0)
                    }))
                }
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    
    @StateObject static var memoGroup = MemoGroup()
    
    static var previews: some View {
        MainListView()
            .environmentObject(memoGroup)
    }
}
