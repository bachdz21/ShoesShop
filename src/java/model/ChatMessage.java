package model;

import java.util.List;

public class ChatMessage {
    private String message;
    private List<Integer> fileIds;

    public ChatMessage() {
    }

    public ChatMessage(String message, List<Integer> fileIds) {
        this.message = message;
        this.fileIds = fileIds;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Integer> getFileIds() {
        return fileIds;
    }

    public void setFileIds(List<Integer> fileIds) {
        this.fileIds = fileIds;
    }
}